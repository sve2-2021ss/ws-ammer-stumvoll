bootstrap: bootstrap-server bootstrap-client

bootstrap-client:
	@echo "⚠️ Ensure that an iPhone 12 Simulator is running"
	cd client && xcrun xcodebuild \
	  -scheme 'Statusdeck (iOS)' \
	  -project statusdeck/Statusdeck.xcodeproj \
	  -configuration Debug \
	  -destination 'platform=iOS Simulator,name=iPhone 12,OS=14.5' \
	  -derivedDataPath build
	cd client && xcrun simctl install \
	"iPhone 12" \
	./build/Build/Products/Debug-iphonesimulator/Statusdeck.app
	cd client && xcrun simctl launch "iPhone 12" com.ammerzon.statusdeck

bootstrap-server:
	@echo "⚠️ Ensure that the Docker daemon is running"
	cd server && docker compose up -d && (npm start&)
	
test-data:
	cd server && npm insert
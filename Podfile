source 'https://github.com/CocoaPods/Specs.git'

def shared_pods
    pod 'Alamofire', '~> 3.0'
end

def testing_pods
    # Adding unit testing libaries
end

target 'MenMa' do
    platform :ios, '8.0'
    use_frameworks!
    shared_pods
end

target 'MenMaTests' do
    platform :ios, '8.0'
    use_frameworks!
    shared_pods
end

target 'MenMa WatchKit Extension' do
    platform :watchos, '2.0'
    use_frameworks!
    shared_pods
end

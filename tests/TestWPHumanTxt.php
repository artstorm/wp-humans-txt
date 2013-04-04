<?php

class TestWPHumanTxt extends WP_UnitTestCase {

    private $plugin;


    public function setUp()
    {
        parent::setUp();
        // $this->plugin = $GLOBALS['wp-humans-txt'];
        // file_put_contents('D:\Dropbox\Code\WordPress\wp-humans-txt\tests\filename.txt', print_r($GLOBALS, true));
        // $this->plugin = WPHumansTxt::getInstance();
    }

    // -------------------------------------------------------------------------
    // Tests
    // -------------------------------------------------------------------------

    public function testPluginInitialization()
    {  
        // var_dump(PostSnippets);
        // $test = PostSnippets::getInstance();
        $this->plugin = WPHumansTxt::getInstance();
        // $this->assertFalse(null == $this->plugin);  
    }

    public function testMethod()
    {
        $test = WPHumansTxt::getInstance();
        var_dump($test);
        $test = $test->testing();
        var_dump($test);
        $this->assertEquals('hello world', $test);
    }

}

<?php

class TestWPHumanTxt extends WP_UnitTestCase {

    private $plugin;

    public function setUp()
    {
        parent::setUp();
        $this->plugin = WPHumansTxt::getInstance();
    }

    // -------------------------------------------------------------------------
    // Tests
    // -------------------------------------------------------------------------

    public function testPluginInitialization()
    {  
        $this->assertFalse(null == $this->plugin);
    }
}

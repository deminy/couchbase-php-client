<?php
# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: couchbase/search/v1/search.proto

namespace Couchbase\Protostellar\Generated\Search\V1;

use Google\Protobuf\Internal\GPBType;
use Google\Protobuf\Internal\RepeatedField;
use Google\Protobuf\Internal\GPBUtil;

/**
 * Generated from protobuf message <code>couchbase.search.v1.SearchQueryResponse</code>
 */
class SearchQueryResponse extends \Google\Protobuf\Internal\Message
{
    /**
     * Generated from protobuf field <code>repeated .couchbase.search.v1.SearchQueryResponse.SearchQueryRow hits = 1;</code>
     */
    private $hits;
    /**
     * Generated from protobuf field <code>map<string, .couchbase.search.v1.SearchQueryResponse.FacetResult> facets = 2;</code>
     */
    private $facets;
    /**
     * Generated from protobuf field <code>optional .couchbase.search.v1.SearchQueryResponse.MetaData meta_data = 3;</code>
     */
    protected $meta_data = null;

    /**
     * Constructor.
     *
     * @param array $data {
     *     Optional. Data for populating the Message object.
     *
     *     @type array<\Couchbase\Protostellar\Generated\Search\V1\SearchQueryResponse\SearchQueryRow>|\Google\Protobuf\Internal\RepeatedField $hits
     *     @type array|\Google\Protobuf\Internal\MapField $facets
     *     @type \Couchbase\Protostellar\Generated\Search\V1\SearchQueryResponse\MetaData $meta_data
     * }
     */
    public function __construct($data = NULL) {
        \GPBMetadata\Couchbase\Search\V1\Search::initOnce();
        parent::__construct($data);
    }

    /**
     * Generated from protobuf field <code>repeated .couchbase.search.v1.SearchQueryResponse.SearchQueryRow hits = 1;</code>
     * @return \Google\Protobuf\Internal\RepeatedField
     */
    public function getHits()
    {
        return $this->hits;
    }

    /**
     * Generated from protobuf field <code>repeated .couchbase.search.v1.SearchQueryResponse.SearchQueryRow hits = 1;</code>
     * @param array<\Couchbase\Protostellar\Generated\Search\V1\SearchQueryResponse\SearchQueryRow>|\Google\Protobuf\Internal\RepeatedField $var
     * @return $this
     */
    public function setHits($var)
    {
        $arr = GPBUtil::checkRepeatedField($var, \Google\Protobuf\Internal\GPBType::MESSAGE, \Couchbase\Protostellar\Generated\Search\V1\SearchQueryResponse\SearchQueryRow::class);
        $this->hits = $arr;

        return $this;
    }

    /**
     * Generated from protobuf field <code>map<string, .couchbase.search.v1.SearchQueryResponse.FacetResult> facets = 2;</code>
     * @return \Google\Protobuf\Internal\MapField
     */
    public function getFacets()
    {
        return $this->facets;
    }

    /**
     * Generated from protobuf field <code>map<string, .couchbase.search.v1.SearchQueryResponse.FacetResult> facets = 2;</code>
     * @param array|\Google\Protobuf\Internal\MapField $var
     * @return $this
     */
    public function setFacets($var)
    {
        $arr = GPBUtil::checkMapField($var, \Google\Protobuf\Internal\GPBType::STRING, \Google\Protobuf\Internal\GPBType::MESSAGE, \Couchbase\Protostellar\Generated\Search\V1\SearchQueryResponse\FacetResult::class);
        $this->facets = $arr;

        return $this;
    }

    /**
     * Generated from protobuf field <code>optional .couchbase.search.v1.SearchQueryResponse.MetaData meta_data = 3;</code>
     * @return \Couchbase\Protostellar\Generated\Search\V1\SearchQueryResponse\MetaData|null
     */
    public function getMetaData()
    {
        return $this->meta_data;
    }

    public function hasMetaData()
    {
        return isset($this->meta_data);
    }

    public function clearMetaData()
    {
        unset($this->meta_data);
    }

    /**
     * Generated from protobuf field <code>optional .couchbase.search.v1.SearchQueryResponse.MetaData meta_data = 3;</code>
     * @param \Couchbase\Protostellar\Generated\Search\V1\SearchQueryResponse\MetaData $var
     * @return $this
     */
    public function setMetaData($var)
    {
        GPBUtil::checkMessage($var, \Couchbase\Protostellar\Generated\Search\V1\SearchQueryResponse\MetaData::class);
        $this->meta_data = $var;

        return $this;
    }

}

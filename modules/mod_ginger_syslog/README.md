mod_ginger_(module name)
========================

> To create a new module from this template:
>
> ```bash
> $ cd ginger/modules
> $ git clone git@github.com:driebit/mod_ginger_template.git mod_ginger_your_new_module
> $ cd mod_ginger_your_new_module && rm -rf .git
> ```

(See the [raw version of this file](https://raw.githubusercontent.com/driebit/mod_ginger_template/master/README.md)
to find out how formatting in Markdown works.)

A Zotonic module for (insert purpose...).

This module is part of [Ginger](http://github.com/driebit/ginger).

Features:

* (core feature 1...)
* (core feature 2...)
* (core feature 3...)

Configuration
-------------

(Describe configuration settings for your module...)

Usage
-----

(Describe how people can use your module...)

## Do this

(Add same chapter headings...)

## Do that

(And show how it‘s done by supplying code examples, for instance:

First, the Zotonic resource is converted into a set of RDF triples. To do so
yourself:)

```erlang
-include_lib("mod_ginger_rdf/include/rdf.hrl").

#rdf_resource{id = Id, triples = Triples} = m_rdf:to_triples(Id, Context).
```

## Models

(If the module contains template models, list them here.)

### m_thingie

(Describe what the template model does.)

## Notifications

(Does your module send notifications? List them here...)

### find_links

(Explain when the notification is sent and give a code example:)

```erlang
-export([
    observe_find_links/3
]).

-include_lib("mod_ginger_rdf/include/rdf.hrl").

observe_find_links(#find_links{id=Id, is_a=CatList}, Links, _Context) ->
    %% Do some search to find relevant RDF links, then return them as a list
    %% of triple records:
    [
        %% An outgoing link
        #triple{
            type=resource,
            subject=Id,
            predicate="http://xmlns.com/foaf/0.1/depiction",
            object="http://example.com/some/external/resource.rdf"
        }
    | Links ].
```

### (some other notification)

## Services

(If the module contains API services, list them here.)

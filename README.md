StockMarkit
===

StockMarkit brings all the great stock information from Markit on Demand (http://dev.markitondemand.com/) to your ruby project.

# Installation

Add it to your gemfile
```
gem 'stock-markit'
```

Install using bundler
```
bundle install
```

or install manually
```
gem install stock-markit
```

# Usage

## Stock Lookup API

```
require 'stock-markit'

StockMarkit.lookup(:twtr) #> [ StockMarkit::Stock ]
```

## Stock Quote API

```
require 'stock-markit'

StockMarkit.quote(:twtr) #> StockMarkit::Quote
```


# Contributing
 * fork the repository
 * create a feature branch
 * add your awesome code
 * send a pull request
 * have a beer


# License
The MIT License (MIT)

Copyright (c) 2016 Michael Heijmans

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

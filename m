Return-Path: <groeck7@gmail.com>
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 2 Mar 2020 13:16:40 -0800
From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v3 0/7] kunit: create a centralized executor to dispatch
 all KUnit tests
Message-ID: <20200302211640.GA8364@roeck-us.net>
References: <20200228012036.15682-1-brendanhiggins@google.com>
 <20200302200337.GH11244@42.do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200302200337.GH11244@42.do-not-panic.com>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Brendan Higgins <brendanhiggins@google.com>, jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com, arnd@arndb.de, keescook@chromium.org, skhan@linuxfoundation.org, alan.maguire@oracle.com, yzaikin@google.com, davidgow@google.com, akpm@linux-foundation.org, rppt@linux.ibm.com, frowand.list@gmail.com, gregkh@linuxfoundation.org, sboyd@kernel.org, logang@deltatee.com, linux-um@lists.infradead.org, linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200302211640.wcNq16vN_UH4t73GuSh-G1tBhcyZLJLDJ3Kc_QXEIxA@z>

On Mon, Mar 02, 2020 at 08:03:37PM +0000, Luis Chamberlain wrote:
> Guenter,
> 
> are you still running your cross-architecture tests? If so any chance

Yes

> you can try this for your build tests?
> 

I didn't have KUNIT_TEST enabled to start with. I did that now, and
started a test run on mainline a minute ago. We'll see how that goes.

Afterwards, sure, I can run the series in a test branch. It would be great
if I can pick it up from a repository somewhere.

Guenter

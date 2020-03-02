From: Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH v3 0/7] kunit: create a centralized executor to dispatch
 all KUnit tests
Date: Mon, 2 Mar 2020 20:03:37 +0000
Message-ID: <20200302200337.GH11244@42.do-not-panic.com>
References: <20200228012036.15682-1-brendanhiggins@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39929 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbgCBUDn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 2 Mar 2020 15:03:43 -0500
Content-Disposition: inline
In-Reply-To: <20200228012036.15682-1-brendanhiggins@google.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Brendan Higgins <brendanhiggins@google.com>, Guenter Roeck <linux@roeck-us.net>
Cc: jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com, arnd@arndb.de, keescook@chromium.org, skhan@linuxfoundation.org, alan.maguire@oracle.com, yzaikin@google.com, davidgow@google.com, akpm@linux-foundation.org, rppt@linux.ibm.com, frowand.list@gmail.com, gregkh@linuxfoundation.org, sboyd@kernel.org, logang@deltatee.com, linux-um@lists.infradead.org, linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org

Guenter,

are you still running your cross-architecture tests? If so any chance
you can try this for your build tests?

Brendan, do you have this code in a branch which can be merged into
linux-next by any chance?

  Luis

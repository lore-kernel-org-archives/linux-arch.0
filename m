From: Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH v2 4/7] init: main: add KUnit to kernel init
Date: Mon, 2 Mar 2020 20:00:27 +0000
Message-ID: <20200302200027.GG11244@42.do-not-panic.com>
References: <20200130230812.142642-1-brendanhiggins@google.com>
 <20200130230812.142642-5-brendanhiggins@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44841 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgCBUAc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 2 Mar 2020 15:00:32 -0500
Content-Disposition: inline
In-Reply-To: <20200130230812.142642-5-brendanhiggins@google.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Brendan Higgins <brendanhiggins@google.com>
Cc: jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com, arnd@arndb.de, keescook@chromium.org, skhan@linuxfoundation.org, alan.maguire@oracle.com, yzaikin@google.com, davidgow@google.com, akpm@linux-foundation.org, rppt@linux.ibm.com, frowand.list@gmail.com, gregkh@linuxfoundation.org, sboyd@kernel.org, logang@deltatee.com, knut.omang@oracle.com, linux-um@lists.infradead.org, linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org

On Thu, Jan 30, 2020 at 03:08:09PM -0800, Brendan Higgins wrote:
> Remove KUnit from init calls entirely, instead call directly from
> kernel_init().
> 
> Co-developed-by: Alan Maguire <alan.maguire@oracle.com>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> Reviewed-by: Stephen Boyd <sboyd@kernel.org>

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

In particular the placement and strategy matches my expectations and
allows us to think of __init as a separate beast, as we should.

  Luis

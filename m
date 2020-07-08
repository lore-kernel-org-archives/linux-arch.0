From: Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH v5 08/12] init: main: add KUnit to kernel init
Date: Wed, 8 Jul 2020 04:38:23 +0000
Message-ID: <20200708043823.GZ4332@42.do-not-panic.com>
References: <20200626210917.358969-1-brendanhiggins@google.com>
 <20200626210917.358969-9-brendanhiggins@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200626210917.358969-9-brendanhiggins@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Brendan Higgins <brendanhiggins@google.com>
Cc: jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com, arnd@arndb.de, keescook@chromium.org, skhan@linuxfoundation.org, alan.maguire@oracle.com, yzaikin@google.com, davidgow@google.com, akpm@linux-foundation.org, rppt@linux.ibm.com, frowand.list@gmail.com, catalin.marinas@arm.com, will@kernel.org, monstr@monstr.eu, mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org, chris@zankel.net, jcmvbkbc@gmail.com, gregkh@linuxfoundation.org, sboyd@kernel.org, logang@deltatee.com, linux-um@lists.infradead.org, linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linux-xtensa@linux-xtensa.org
List-Id: linux-arch.vger.kernel.org

On Fri, Jun 26, 2020 at 02:09:13PM -0700, Brendan Higgins wrote:
> Remove KUnit from init calls entirely, instead call directly from
> kernel_init().

The commit log does not explain *why*.

> Co-developed-by: Alan Maguire <alan.maguire@oracle.com>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> Reviewed-by: Stephen Boyd <sboyd@kernel.org>

Other than that:

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis

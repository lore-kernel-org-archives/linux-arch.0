From: Denys Vlasenko <vda.linux@googlemail.com>
Subject: Re: [PATCH 1/23] make section names compatible with -ffunction-sections -fdata-sections
Date: Wed, 2 Jul 2008 02:03:54 +0200
Message-ID: <200807020203.54809.vda.linux@googlemail.com>
References: <200807020233.48646.vda.linux@googlemail.com> <60320.1214952973@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1761433AbYGBAEW@vger.kernel.org>
In-Reply-To: <60320.1214952973@turing-police.cc.vt.edu>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Valdis.Kletnieks@vt.edu
Cc: linux-arch@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Russell King <rmk@arm.linux.org.uk>, David Howells <dhowells@redhat.com>, Ralf Baechle <ralf@linux-mips.org>, Lennert Buytenhek <kernel@wantstofly.org>, Josh Boyer <jwboyer@linux.vnet.ibm.com>, Paul Mackerras <paulus@samba.org>, David Woodhouse <dwmw2@infradead.org>, Andi Kleen <andi@firstfloor.org>, torvalds@linux-foundation.org, Paul Gortmaker <paul.gortmaker@windriver.com>, linux-embedded@vger.kernel.org, linux-kernel@vger.kernel.org, Tim Bird <tim.bird@am.sony.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Dave Miller <davem@davemloft.net>
List-Id: linux-arch.vger.kernel.org

On Wednesday 02 July 2008 00:56, Valdis.Kletnieks@vt.edu wrote:
> On Wed, 02 Jul 2008 02:33:48 +0200, Denys Vlasenko said:
> 
> > The purpose of these patches is to make kernel buildable
> > with "gcc -ffunction-sections -fdata-sections".
> > 
> > Newer gcc and binutils can do dead code and data removal
> > at link time. It is achieved using combination of
> > -ffunction-sections -fdata-sections options for gcc and
> > --gc-sections for ld.
> 
> Interesting idea.  Do you happen to have before-and-after 'size vmlinux'
> numbers to show how much space is actually reclaimed?

After this patch there will be no change - it does not do
dead code and data removal. I submitted bigger change before
but it was probably too big for digestion.

That earlier version was achieving ~10% kernel size reduction
if kernel is built without loadable module support
(loadable modules interfere with linker's dead code
and data removal, need to add some rather contrived magic
to make it work there too. Left as TODO for later).
--
vda

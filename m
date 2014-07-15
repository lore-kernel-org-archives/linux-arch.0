From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 24/29] nios2: Module support
Date: Tue, 15 Jul 2014 14:21:49 +0200
Message-ID: <5671533.7yANBX1RSQ@wuerfel>
References: <1405413956-2772-1-git-send-email-lftan@altera.com> <6364841.e2Acy30lOs@wuerfel> <20140715111237.GF7668@distanz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20140715111237.GF7668@distanz.ch>
Sender: linux-doc-owner@vger.kernel.org
To: Tobias Klauser <tklauser@distanz.ch>
Cc: Ley Foon Tan <lftan@altera.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, lftan.linux@gmail.com, cltang@codesourcery.com
List-Id: linux-arch.vger.kernel.org

On Tuesday 15 July 2014 13:12:37 Tobias Klauser wrote:
> On 2014-07-15 at 12:24:46 +0200, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Tuesday 15 July 2014 16:45:51 Ley Foon Tan wrote:
> > > +void *module_alloc(unsigned long size)
> > > +{
> > > +   if (size == 0)
> > > +           return NULL;
> > > +   return kmalloc(size, GFP_KERNEL);
> > > +}
> > > +
> > > +/* Free memory returned from module_alloc */
> > > +void module_free(struct module *mod, void *module_region)
> > > +{
> > > +   kfree(module_region);
> > > +}
> > 
> > Any particular reason for defining these to use kmalloc rather than
> > the default vmalloc based functions?
> 
> AFAIR this is due to relocation issues, as the FIXME comment in the
> "original" code [1] states. I don't know whether this still applies,
> though (or what would be the proper fix for this to overcome the
> relocation issues).
> 
> [1] https://github.com/tklauser/linux-nios2/blob/nios2/arch/nios2/kernel/module.c#L45
> 

Ah, I see. Please at least copy over that comment then.

A long-term solution would be to copy what ARM does, since that
has the same problem. The modules are allocated with
__vmalloc_node_range, passing a virtual address range that
is just before the kernel virtual address, taken out of the
top 16MB of the user space addresses.

	Arnd

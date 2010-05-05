Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:63166 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754343Ab0EEC7b (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 4 May 2010 22:59:31 -0400
Date: Wed, 5 May 2010 11:59:24 +0900
From: Takuya Yoshikawa <takuya.yoshikawa@gmail.com>
Subject: Re: [RFC][PATCH resend 8/12] asm-generic: bitops: introduce le bit
 offset macro
Message-ID: <20100505115924.7bb92036.takuya.yoshikawa@gmail.com>
In-Reply-To: <4BE04677.4060608@redhat.com>
References: <20100504215645.6448af8f.takuya.yoshikawa@gmail.com>
	<20100504220500.7695cd66.takuya.yoshikawa@gmail.com>
	<201005041703.00549.arnd@arndb.de>
	<4BE04677.4060608@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Avi Kivity <avi@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>, mtosatti@redhat.com, agraf@suse.de, yoshikawa.takuya@oss.ntt.co.jp, fernando@oss.ntt.co.jp, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org, kvm-ia64@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, benh@kernel.crashing.org, paulus@samba.org, linuxppc-dev@ozlabs.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20100505025924.tRo8fkpmZt-q9apTqNfVrin9sP2vYjWGUGvX49cS6DA@z>

On Tue, 04 May 2010 19:08:23 +0300
Avi Kivity <avi@redhat.com> wrote:

> On 05/04/2010 06:03 PM, Arnd Bergmann wrote:
> > On Tuesday 04 May 2010, Takuya Yoshikawa wrote:
...
> >> So let us use the le bit offset calculation part by defining it as a new
> >> macro: generic_le_bit_offset() .
> >>      
> > Does this work correctly if your user space is 32 bits (i.e. unsigned long
> > is different size in user space and kernel) in both big- and little-endian
> > systems?
> >
> > I'm not sure about all the details, but I think you cannot in general share
> > bitmaps between user space and kernel because of this.
> >    
> 
> That's why the bitmaps are defined as little endian u64 aligned, even on 
> big endian 32-bit systems.  Little endian bitmaps are wordsize agnostic, 
> and u64 alignment ensures we can use long-sized bitops on mixed size 
> systems.

There was a suggestion to propose set_le_bit_user() kind of macros.
But what I thought was these have a constraint you two explained and seemed to be
a little bit specific to some area, like KVM.

So I decided to propose just the offset calculation macro.

  Thanks, Takuya

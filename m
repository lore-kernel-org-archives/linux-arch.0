From: David Rientjes <rientjes@google.com>
Subject: Re: Link breakage on all architectures which implement their own
 show_mem
Date: Thu, 24 Mar 2011 15:21:46 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1103241520120.26730@chino.kir.corp.google.com>
References: <1300898506.15899.24.camel@mulgrave.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:50703 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932915Ab1CXWVy (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 24 Mar 2011 18:21:54 -0400
Received: from hpaq11.eem.corp.google.com (hpaq11.eem.corp.google.com [172.25.149.11])
	by smtp-out.google.com with ESMTP id p2OMLrvI026851
	for <linux-arch@vger.kernel.org>; Thu, 24 Mar 2011 15:21:53 -0700
Received: from pwi3 (pwi3.prod.google.com [10.241.219.3])
	by hpaq11.eem.corp.google.com with ESMTP id p2OMLo8d028861
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-arch@vger.kernel.org>; Thu, 24 Mar 2011 15:21:51 -0700
Received: by pwi3 with SMTP id 3so69650pwi.9
        for <linux-arch@vger.kernel.org>; Thu, 24 Mar 2011 15:21:49 -0700 (PDT)
In-Reply-To: <1300898506.15899.24.camel@mulgrave.site>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: linux-arch@vger.kernel.org

On Wed, 23 Mar 2011, James Bottomley wrote:

> This is the problem a lot of architectures will see:
> 
> Specifically this:
>   LD      vmlinux.o
> lib/lib.a(show_mem.o): In function `show_mem':
> (.text.show_mem+0x0): multiple definition of `show_mem'
> arch/parisc/mm/built-in.o:(.text.show_mem+0x0): first defined here
> make: *** [vmlinux.o] Error 1
> 
> Caused by this patch:
> 
> commit ddd588b5dd55f14320379961e47683db4e4c1d90
> Author: David Rientjes <rientjes@google.com>
> Date:   Tue Mar 22 16:30:46 2011 -0700
> 
>     oom: suppress nodes that are not allowed from meminfo on oom kill
> 
> Is the cause.  What it does is introduce a new __show_mem() which is
> required by files in mm/, so the object containing it: show_mem.o gets
> pulled in all the time in the link and that gives every architecture
> that implements their own show_mem() a link failure because of the
> double definition.  Library linking works at the file level, not at the
> function level.  To work, you have to put these functions in separate
> files.
> 

Thanks for the report, James.

This was also reported by Stephen on LKML when he merged the latest Linus 
tree into linux-next.  Andrew suggested that we remove __show_mem() 
entirely and simply add its argument to show_mem() in all the 
architectures.  I have a patch at:

	http://marc.info/?l=linux-kernel&m=130100511521954

I don't have a parisc cross compiler, so if you could try it out and add 
your Tested-by that would be great

Thanks again!

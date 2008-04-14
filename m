Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from rv-out-0708.google.com ([209.85.198.240]:51882 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752302AbYDNWSj (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 14 Apr 2008 18:18:39 -0400
Received: by rv-out-0506.google.com with SMTP id k29so714617rvb.1
        for <linux-arch@vger.kernel.org>; Mon, 14 Apr 2008 15:18:37 -0700 (PDT)
Subject: Re: [PATCHv4 1/2] kernel: add common infrastructure for unaligned
	access
From: Harvey Harrison <harvey.harrison@gmail.com>
In-Reply-To: <20080414151417.f8ab4365.akpm@linux-foundation.org>
References: <1208195406.5721.47.camel@brick>
	 <20080414151417.f8ab4365.akpm@linux-foundation.org>
Content-Type: text/plain
Date: Mon, 14 Apr 2008 15:18:37 -0700
Message-ID: <1208211517.5721.61.camel@brick>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-arch@vger.kernel.org, torvalds@linux-foundation.org, dhowells@redhat.com, rmk@arm.linux.org.uk
Message-ID: <20080414221837.qrvlRj9z4U1ux_MPa0ePWMHn-MJvg6EfM04wxzCZf3I@z>

On Mon, 2008-04-14 at 15:14 -0700, Andrew Morton wrote:
> On Mon, 14 Apr 2008 10:50:06 -0700
> Harvey Harrison <harvey.harrison@gmail.com> wrote:
> 
> > Create a linux/unaligned folder similar in spirit to the linux/byteorder
> > folder to hold generic implementations collected from various arches.
> 
> ooh, there's a cultural faux pas.  I changed it to "directory" ;)
> 

Damn, I was hoping to hide some unfortunate mental damage early on in
life ;)

Cheers,

Harvey


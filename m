From: David Rientjes <rientjes@google.com>
Subject: Re: Link breakage on all architectures which implement their own
 show_mem
Date: Fri, 25 Mar 2011 13:02:41 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1103251301490.23297@chino.kir.corp.google.com>
References: <1300898506.15899.24.camel@mulgrave.site> <alpine.DEB.2.00.1103241520120.26730@chino.kir.corp.google.com> <1301062421.4073.3.camel@mulgrave.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp-out.google.com ([74.125.121.67]:33955 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752809Ab1CYUCt (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 25 Mar 2011 16:02:49 -0400
Received: from wpaz37.hot.corp.google.com (wpaz37.hot.corp.google.com [172.24.198.101])
	by smtp-out.google.com with ESMTP id p2PK2lvt008706
	for <linux-arch@vger.kernel.org>; Fri, 25 Mar 2011 13:02:47 -0700
Received: from pzk32 (pzk32.prod.google.com [10.243.19.160])
	by wpaz37.hot.corp.google.com with ESMTP id p2PK1sre013020
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-arch@vger.kernel.org>; Fri, 25 Mar 2011 13:02:45 -0700
Received: by pzk32 with SMTP id 32so292324pzk.14
        for <linux-arch@vger.kernel.org>; Fri, 25 Mar 2011 13:02:45 -0700 (PDT)
In-Reply-To: <1301062421.4073.3.camel@mulgrave.site>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: linux-arch@vger.kernel.org

On Fri, 25 Mar 2011, James Bottomley wrote:

> > I don't have a parisc cross compiler, so if you could try it out and add 
> > your Tested-by that would be great
> 
> I'm afraid this hit at exactly the wrong time (we're relocating the
> parisc dev cluster in cupertino), so all my parisc build systems are
> currently trekking across country on fedex mules.
> 

Haha, ok.  Linus merged the patch into his tree so you should hear from 
parisc people if there is additional breakage, which there shouldn't be.  
Thanks again for the report.

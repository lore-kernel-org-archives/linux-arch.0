From: Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: [PATCH 2/2] Add dev.mem.restricted sysctl
Date: Sun, 16 Nov 2008 13:13:18 +0300
Message-ID: <20081116101318.GA31541@x200.localdomain>
References: <1226793823-32360-1-git-send-email-bwalle@suse.de> <1226793823-32360-3-git-send-email-bwalle@suse.de> <20081116003327.GA2405@x200.localdomain> <20081116102843.35658969@kopernikus.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.168]:42535 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751626AbYKPKJo (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 16 Nov 2008 05:09:44 -0500
Received: by ug-out-1314.google.com with SMTP id 39so203356ugf.37
        for <linux-arch@vger.kernel.org>; Sun, 16 Nov 2008 02:09:42 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20081116102843.35658969@kopernikus.site>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Bernhard Walle <bwalle@suse.de>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Sun, Nov 16, 2008 at 10:28:43AM +0100, Bernhard Walle wrote:
> * Alexey Dobriyan [2008-11-16 03:33]:
> >
> > On Sun, Nov 16, 2008 at 01:03:43AM +0100, Bernhard Walle wrote:
> > > --- a/include/linux/sysctl.h
> > > +++ b/include/linux/sysctl.h
> > > @@ -858,6 +858,7 @@ enum {
> > >  	DEV_MAC_HID=5,
> > >  	DEV_SCSI=6,
> > >  	DEV_IPMI=7,
> > > +	DEV_MEM=8,
> > >  };
> > >  
> > >  /* /proc/sys/dev/cdrom */
> > > @@ -875,6 +876,11 @@ enum {
> > >  	DEV_PARPORT_DEFAULT=-3
> > >  };
> > >  
> > > +/* /proc/sys/dev/mem */
> > > +enum {
> > > +    DEV_MEM_RESTRICTED=1,
> > > +};
> > 
> > No new binary sysctls please.
> 
> Why is that sysctl binary? It's just an integer.

It's a name for sysctls accessible via sysctl(2).

Please, if you're adding sysctl, supply only .procname and make it accessible
only via /proc/sys/.

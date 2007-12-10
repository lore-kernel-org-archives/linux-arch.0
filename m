Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:46978 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751899AbXLJQRg (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 10 Dec 2007 11:17:36 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH][RFC] freezer : add the TIF_FREEZE flag to all archs
Date: Mon, 10 Dec 2007 17:36:29 +0100
References: <47594F8C.7070900@fr.ibm.com>
In-Reply-To: <47594F8C.7070900@fr.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200712101736.29676.rjw@sisk.pl>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Cedric Le Goater <clg@fr.ibm.com>
Cc: linux-pm@lists.linux-foundation.org, linux-arch@vger.kernel.org, Linux Containers <containers@lists.osdl.org>

On Friday, 7 of December 2007, Cedric Le Goater wrote:
> From: Cedric Le Goater <clg@fr.ibm.com>

Sorry for the delay, I somehow managed to overlook your message.

> This patch is the first step in making the refrigerator() available 
> to all architectures, even for those without power management. 
>
> The purpose of such a change is to be able to use the refrigerator() 
> in a new control group subsystem which will implement a control group
> freezer.

Hm, sounds interesting, but ...
 
> If you think this is safe and not utterly stupid, I'll send the rest
> of the patchset exporting the refrigerator to all arches.

... you will need to provide some details, I think.

I also think that it's safe to define TIF_FREEZE for all architectures, but
the usefulness of it will very much depend on the purpose. :-)

Greetings,
Rafael

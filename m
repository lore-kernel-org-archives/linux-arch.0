Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:53836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727438AbfGCBIF (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 2 Jul 2019 21:08:05 -0400
Date: Tue, 2 Jul 2019 15:19:14 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: Archs using generic PCI controller drivers vs. resource policy
Message-ID: <20190702201914.GD128603@google.com>
References: <5f3dcc3a8dafad188e3adb8ee9cf347bebdee7f6.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f3dcc3a8dafad188e3adb8ee9cf347bebdee7f6.camel@kernel.crashing.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-pci@vger.kernel.org, linux-arch@vger.kernel.org

On Sun, Jun 23, 2019 at 10:30:42AM +1000, Benjamin Herrenschmidt wrote:
> Hi !
> 
> As part of my cleanup and consolidation of the PCI resource assignment
> policies, I need to clarify something.
> 
> At the moment, unless PCI_PROBE_ONLY is set, a number of
> platforms/archs expect Linux to reassign everything rather than honor
> what has setup, then (re)assign what's left or broken.

I don't think "reassign everything" is any different from "honor what
has been setup and (re)assign what's left or broken".

"Reassign everything" is clearly allowed to produce the exact same
result as "honor what has been setup and (re)assign what's left or
broken".

I claim any difference between the two is actually a fragile
dependency on the Linux assignment algorithm that is likely to break
as that algorithm changes.

Or am I missing something?

Bjorn

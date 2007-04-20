Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ns.suse.de ([195.135.220.2]:40397 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753512AbXDTK4W (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 20 Apr 2007 06:56:22 -0400
From: Andi Kleen <ak@suse.de>
Subject: larger per cpu data
Date: Fri, 20 Apr 2007 12:46:17 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200704201246.17531.ak@suse.de>
Sender: linux-arch-owner@vger.kernel.org
To: tony.luck@intel.com
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Hi,

I've been looking at optimizing the network per CPU statistics and the best way to 
do that would be to move them back to direct per CPU data. Currently they are
allocated separately because there used to be some trouble on x86 (and ia64?) 
with limited per CPU areas. At least the x86 side has been fixed now. I heard
there were some problems with ia64 have those been fixed too?
Anybody would have a problem with increasing per CPU data in a standard kernel
by a few KB?

-Andi
 

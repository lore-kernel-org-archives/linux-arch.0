Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:57927 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753764Ab3AVIXv (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 22 Jan 2013 03:23:51 -0500
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 29/76] ARC: Boot #1: low-level, setup_arch(), /proc/cpuinfo, mem init
Date: Tue, 22 Jan 2013 08:23:44 +0000
References: <1358511930-7424-1-git-send-email-vgupta@synopsys.com> <201301181445.39050.arnd@arndb.de> <50FE4497.3050306@synopsys.com>
In-Reply-To: <50FE4497.3050306@synopsys.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-ID: <201301220823.44872.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20130122082344.-Kb1IRQ7bGTFg2cV2NhcPq7p9KGN7rOJjBFKG_e8F_k@z>

On Tuesday 22 January 2013, Vineet Gupta wrote:
> How does the following look like. This is RFC only and I'll squash it into Boot #1
> patch.
> 
> From: Vineet Gupta <vgupta@synopsys.com>
> Date: Tue, 22 Jan 2013 13:03:50 +0530
> Subject: [PATCH] RFC: Convert ARC port from bootmem to memblock
> 
> Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
> ---

Looks good to me, although I might be missing some details.

Given that everything still seems to work for you,

Acked-by: Arnd Bergmann <arnd@arndb.de>

on the combined patch.

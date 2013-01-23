From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [PATCH v2 65/76] ARC: UAPI Disintegrate arch/arc/include/asm
Date: Wed, 23 Jan 2013 17:04:28 +0530
Message-ID: <50FFCAC4.1050002@synopsys.com>
References: <1358511930-7424-1-git-send-email-vgupta@synopsys.com> <1358511930-7424-66-git-send-email-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from vaxjo.synopsys.com ([198.182.60.75]:36793 "EHLO
	vaxjo.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755159Ab3AWLen (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 23 Jan 2013 06:34:43 -0500
In-Reply-To: <1358511930-7424-66-git-send-email-vgupta@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, arnd@arndb.de

On Friday 18 January 2013 05:55 PM, Vineet Gupta wrote:
> 1. ./genfilelist.pl arch/arc/include/asm/
> 
> 2. Create arch/arc/include/uapi/asm/Kbuild as follows
> 
> 	+# UAPI Header export list
> 	+include include/uapi/asm-generic/Kbuild.asm
> 
> 3. ./disintegrate-one.pl arch/arc/include/{,uapi/}asm/<above-list>
> 
> 4. Edit arch/arc/include/asm/Kbuild to remove ref to
> 	asm-generic/Kbuild.asm
> 
> Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
> Cc: David Howells <dhowells@redhat.com>

Hi David,

I generated this patch using the scripts you provided. If these look OK to you,
can you please ACK.

Thx,
-Vineet

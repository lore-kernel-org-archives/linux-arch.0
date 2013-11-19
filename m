Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from multi.imgtec.com ([194.200.65.239]:47548 "EHLO multi.imgtec.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752611Ab3KSNPx (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 19 Nov 2013 08:15:53 -0500
Message-ID: <528B643F.1020904@imgtec.com>
Date: Tue, 19 Nov 2013 13:14:39 +0000
From: James Hogan <james.hogan@imgtec.com>
MIME-Version: 1.0
Subject: Re: [PATCH 4/9] metag: Remove duplicate DT selection logic
References: <5283A000.8090007@gmail.com> <1384859554-27268-1-git-send-email-geert@linux-m68k.org> <1384859554-27268-4-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1384859554-27268-4-git-send-email-geert@linux-m68k.org>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Rob Herring <rob.herring@calxeda.com>, devicetree@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-metag@vger.kernel.org
Message-ID: <20131119131439.P40A3ONztIE6fS4vFJKuPUDEP206wMgZ2Z5Q1YYcjTM@z>

On 19/11/13 11:12, Geert Uytterhoeven wrote:
> early_init_dt_scan() now takes care of falling back to the built-in DTB.
> Note that we now have to check ourselves whether original_cmd_line is
> a DTB or a command line, to keep command line append working.
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: James Hogan <james.hogan@imgtec.com>
> Cc: linux-metag@vger.kernel.org

Looks good and seems to work fine.
Acked-by: James Hogan <james.hogan@imgtec.com>

Thanks
James


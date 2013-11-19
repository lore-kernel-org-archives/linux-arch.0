Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from multi.imgtec.com ([194.200.65.239]:47633 "EHLO multi.imgtec.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752103Ab3KSN1a (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 19 Nov 2013 08:27:30 -0500
Message-ID: <528B6740.1030402@imgtec.com>
Date: Tue, 19 Nov 2013 13:27:28 +0000
From: James Hogan <james.hogan@imgtec.com>
MIME-Version: 1.0
Subject: Re: [PATCH 1/9] dt: Handle passed/built-in DT selection in early_init_dt_scan()
References: <5283A000.8090007@gmail.com> <1384859554-27268-1-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1384859554-27268-1-git-send-email-geert@linux-m68k.org>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Rob Herring <rob.herring@calxeda.com>, devicetree@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20131119132728.ZCZ6RSJG9w1d8sDvpfYUsLME8AL9WkLQ73AVejotl6E@z>

On 19/11/13 11:12, Geert Uytterhoeven wrote:
> Let early_init_dt_scan() fall-back to the built-in DT if no DT was passed,
> or if it's invalid, so architectures don't have to duplicate this logic.
> 
> Suggested-by: Rob Herring <rob.herring@calxeda.com>
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

Reviewed-by: James Hogan <james.hogan@imgtec.com>

Thanks
James


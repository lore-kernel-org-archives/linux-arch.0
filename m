Return-Path: <James.Bottomley@SteelEye.com>
Received: from stat1.steeleye.com ([65.114.3.130]:53725 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S264016AbUDVM7n (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 22 Apr 2004 08:59:43 -0400
Subject: Re: [Patch] SMP call function cleanup
From: James Bottomley <James.Bottomley@SteelEye.com>
In-Reply-To: <20040422123703.GY22027@krispykreme>
References: <1082636511.1332.34.camel@halo>
	<20040422122818.GR743@holomorphy.com>  <20040422123703.GY22027@krispykreme>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: 22 Apr 2004 08:59:39 -0400
Message-Id: <1082638779.1778.16.camel@mulgrave>
Mime-Version: 1.0
To: Anton Blanchard <anton@samba.org>
Cc: William Lee Irwin III <wli@holomorphy.com>, Jan Glauber <glauber@gmx.de>, linux-arch@vger.kernel.org, schwidefsky@de.ibm.com
List-ID: <linux-arch.vger.kernel.org>

On Thu, 2004-04-22 at 08:37, Anton Blanchard wrote:
> Unless there is a need Id prefer not to. Some arches do not support IPI
> to a cpumask, whereas they should do send to all and send to single.

This is my preference too.  Voyager is one such arch.

If it's added, there certainly has to be some way of ensuring that the
cpumask variant isn't used preferentially to execute on a single cpu .

James

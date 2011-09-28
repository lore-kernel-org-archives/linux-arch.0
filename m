From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 05/24] C6X: build infrastructure
Date: Wed, 28 Sep 2011 15:23:15 +0200
Message-ID: <201109281523.15680.arnd@arndb.de>
References: <1317155405-26235-1-git-send-email-msalter@redhat.com> <1317155405-26235-6-git-send-email-msalter@redhat.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:53138 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752814Ab1I1NXY (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 28 Sep 2011 09:23:24 -0400
In-Reply-To: <1317155405-26235-6-git-send-email-msalter@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mark Salter <msalter@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Tuesday 27 September 2011, Mark Salter wrote:
> +comment "Board Selection"
> +choice
> +       prompt "Board"
> +       help
> +         This option specifies the specific board for which the kernel will be
> +         compiled.
> +
> +config BOARD_DSK6455
> +       bool "DSK6455"
> +       select SOC_TMS320C6455
> +
> +config BOARD_EVM6457
> +       bool "EVM6472"
> +       select SOC_TMS320C6457
> +
> +config BOARD_EVM6472
> +       bool "EVM6472"
> +       select SOC_TMS320C6472
> +
> +config BOARD_EVM6474
> +       bool "EVM6474"
> +       select SOC_TMS320C6474
> +
> +endchoice

This really wants to be a flat list instead of a "choice" statement,
so you can build a kernel for multiple boards at once. Is there a
reason why this is not possible right now?

Also, how different are these boards and socs still? Since you are
based on device trees for hardware configuration, do you actually
need the options at all?

	Arnd

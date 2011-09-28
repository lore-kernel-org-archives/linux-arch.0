From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 22/24] C6X: EMIF - External Memory Interface
Date: Wed, 28 Sep 2011 16:13:27 +0200
Message-ID: <201109281613.27164.arnd@arndb.de>
References: <1317155405-26235-1-git-send-email-msalter@redhat.com> <1317155405-26235-23-git-send-email-msalter@redhat.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:57890 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754577Ab1I1ON3 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 28 Sep 2011 10:13:29 -0400
In-Reply-To: <1317155405-26235-23-git-send-email-msalter@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mark Salter <msalter@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Tuesday 27 September 2011, Mark Salter wrote:
> Several SoC parts provide a simple bridge to support external memory mapped
> devices. This code probes the device tree for an EMIF node and sets up the
> bridge registers if such a node is found. Beyond initial set up, there is no
> further need to access the bridge control registers. External devices on the
> bus are accessed through their MMIO registers using suitable drivers. The
> bridge hardware does provide for timeout and other error interrupts, but these
> are not yet supported.
> 
> Signed-off-by: Mark Salter <msalter@redhat.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>

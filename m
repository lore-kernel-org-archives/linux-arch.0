From: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 3/3] Remove CONFIG_STRICT_DEVMEM
Date: Mon, 17 Nov 2008 13:57:38 +0000
Message-ID: <32168.1226930258@redhat.com>
References: <20081116162149.07f05c7c@kopernikus.site> <1226846868-9595-1-git-send-email-bwalle@suse.de> <1226846868-9595-4-git-send-email-bwalle@suse.de> <20081116150901.4d824e6d@lxorguk.ukuu.org.uk>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.redhat.com ([66.187.237.31]:49046 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751988AbYKQN54 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 17 Nov 2008 08:57:56 -0500
In-Reply-To: <20081116162149.07f05c7c@kopernikus.site>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Bernhard Walle <bwalle@suse.de>
Cc: dhowells@redhat.com, Alan Cox <alan@lxorguk.ukuu.org.uk>, x86@kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, crash-utility@redhat.com

Bernhard Walle <bwalle@suse.de> wrote:

> For embedded users, do they use CONFIG_SYSCTL at all?

Yes.  It still allows you to configure various things about the kernel.

David

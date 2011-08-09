From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 23/24] C6X: miscellaneous low-level SoC support
Date: Tue, 9 Aug 2011 19:10:21 +0200
Message-ID: <201108091910.21405.arnd@arndb.de>
References: <1312839879-13592-1-git-send-email-msalter@redhat.com> <1312839879-13592-24-git-send-email-msalter@redhat.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:54639 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753893Ab1HIRKY (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 9 Aug 2011 13:10:24 -0400
In-Reply-To: <1312839879-13592-24-git-send-email-msalter@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mark Salter <msalter@redhat.com>
Cc: linux-arch@vger.kernel.org

On Monday 08 August 2011, Mark Salter wrote:
> Signed-off-by: Mark Salter <msalter@redhat.com>

These definitely need some explanation about what the two drivers actually do.
In fact, a lot of the patches you sent seem to lack any description whatsoever.

Also, the settings that you put into the drivers are hardcoded in soc-specific
code. It would be much better to integrate all this into the device tree
probing mechanism.

	Arnd

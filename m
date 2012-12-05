Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from [206.117.179.246] ([206.117.179.246]:36404 "EHLO labridge.com"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751599Ab2LESxo (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 5 Dec 2012 13:53:44 -0500
Message-ID: <1354733607.8320.3.camel@joe-AO722>
Subject: Re: [PATCH v2 12/44] metag: TBX source
From: Joe Perches <joe@perches.com>
Date: Wed, 05 Dec 2012 10:53:27 -0800
In-Reply-To: <1354723742-6195-13-git-send-email-james.hogan@imgtec.com>
References: <1354723742-6195-1-git-send-email-james.hogan@imgtec.com>
	 <1354723742-6195-13-git-send-email-james.hogan@imgtec.com>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James Hogan <james.hogan@imgtec.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Message-ID: <20121205185327.mk6GvGMth4xd4PxKB7Lk5tDKVTFsTBvrO3t-NJiaACk@z>

On Wed, 2012-12-05 at 16:08 +0000, James Hogan wrote:
> Add source files from the Thread Binary Interface (TBI) library which
> provides useful low level operations and traps/context management.
[]
>  arch/metag/tbx/tbicache.c  |  462 ++++++++++++++++++++++++++++++++++++++++++++

Could you please run checkpatch on this file?



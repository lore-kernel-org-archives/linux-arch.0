From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 1/5] bug: When !CONFIG_BUG, simplify WARN_ON_ONCE and family
Date: Wed, 26 Feb 2014 14:24:59 +0100
Message-ID: <201402261424.59875.arnd@arndb.de>
References: <469b5dc113cb468232291527642f8dc47663e945.1393385236.git.josh@joshtriplett.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.13]:62082 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750814AbaBZNZH (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 26 Feb 2014 08:25:07 -0500
In-Reply-To: <469b5dc113cb468232291527642f8dc47663e945.1393385236.git.josh@joshtriplett.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Josh Triplett <josh@joshtriplett.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

On Wednesday 26 February 2014, Josh Triplett wrote:
> When !CONFIG_BUG, WARN_ON and family become simple passthroughs of their
> condition argument; however, WARN_ON_ONCE and family still have
> conditions and a boolean to detect one-time invocation, even though the
> warning they'd emit doesn't exist.  Make the existing definitions
> conditional on CONFIG_BUG, and add definitions for !CONFIG_BUG that map
> to the passthrough versions of WARN and WARN_ON.
> 
> This saves 4.4k on a minimized configuration (smaller than
> allnoconfig), and 20.6k with defconfig plus CONFIG_BUG=n.
> 
> Signed-off-by: Josh Triplett <josh@joshtriplett.org>

Acked-by: Arnd Bergmann <arnd@arndb.de>

From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 4/5] bug: Use a common definition of BUG_ON regardless of CONFIG_BUG
Date: Wed, 26 Feb 2014 14:26:37 +0100
Message-ID: <201402261426.37800.arnd@arndb.de>
References: <469b5dc113cb468232291527642f8dc47663e945.1393385236.git.josh@joshtriplett.org> <6ce38c3701f8ed1d30bfc1661ede7eade46a79c6.1393385236.git.josh@joshtriplett.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.13]:54179 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752089AbaBZN0l (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 26 Feb 2014 08:26:41 -0500
In-Reply-To: <6ce38c3701f8ed1d30bfc1661ede7eade46a79c6.1393385236.git.josh@joshtriplett.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Josh Triplett <josh@joshtriplett.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

On Wednesday 26 February 2014, Josh Triplett wrote:
> 
> include/asm-generic/bug.h defines BUG_ON to call BUG() if CONFIG_BUG=y,
> or as a no-op if !CONFIG_BUG.  However, BUG() is already a no-op if
> !CONFIG_BUG, making this pointless.  Use a common definition that always
> calls BUG().
> 
> This does not change the compiled code at all.
> 
> Signed-off-by: Josh Triplett <josh@joshtriplett.org>

Acked-by: Arnd Bergmann <arnd@arndb.de>

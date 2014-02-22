From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH RESEND] bug: When !CONFIG_BUG, simplify WARN_ON_ONCE and
 family
Date: Sat, 22 Feb 2014 14:31:20 -0800
Message-ID: <20140222223120.GB4643@thin>
References: <20140222192325.GA12587@thin>
 <53091CA9.3060403@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:35720 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751877AbaBVWb3 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 22 Feb 2014 17:31:29 -0500
Content-Disposition: inline
In-Reply-To: <53091CA9.3060403@infradead.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

On Sat, Feb 22, 2014 at 01:54:49PM -0800, Randy Dunlap wrote:
> On 02/22/2014 11:23 AM, Josh Triplett wrote:
> 
> Hi Josh,
> 
> If you redo these patches, please make while(0) not look like a
> function call, i.e., use while (0) instead.

Good catch.  Fixing in v2.

- Josh Triplett

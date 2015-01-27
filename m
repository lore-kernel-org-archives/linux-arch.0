From: Jesper Nilsson <jesper.nilsson@axis.com>
Subject: Re: [PATCH v2 33/40] cris: macro whitespace fixes
Date: Tue, 27 Jan 2015 17:28:08 +0100
Message-ID: <20150127162808.GC26817@axis.com>
References: <1420558883-10131-1-git-send-email-mst@redhat.com>
 <1420558883-10131-34-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bes.se.axis.com ([195.60.68.10]:35150 "EHLO bes.se.axis.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752683AbbA0Q2K (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 27 Jan 2015 11:28:10 -0500
Content-Disposition: inline
In-Reply-To: <1420558883-10131-34-git-send-email-mst@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Mikael Starvik <starvik@axis.com>, Jesper Nilsson <jespern@axis.com>, linux-cris-kernel <linux-cris-kernel@axis.com>

On Tue, Jan 06, 2015 at 04:45:21PM +0100, Michael S. Tsirkin wrote:
> While working on arch/cris/include/asm/uaccess.h, I noticed
> that some macros within this header are made harder to read because they
> violate a coding style rule: space is missing after comma.
> 
> Fix it up.

Thanks, looks good.
I'll take it into the CRIS tree for 3.20.

> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

/^JN - Jesper Nilsson
-- 
               Jesper Nilsson -- jesper.nilsson@axis.com

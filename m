From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [PATCH 18/20] um: use generic show_mem()
Date: Fri, 27 Jun 2008 11:08:30 -0400
Message-ID: <20080627150830.GA8381@c2.user-mode-linux.org>
References: <20080627115349.743368154@saeurebad.de> <20080627120050.500232841@saeurebad.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from saraswathi.solana.com ([198.99.130.12]:41795 "EHLO
	saraswathi.solana.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758421AbYF0RMY (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 27 Jun 2008 13:12:24 -0400
Content-Disposition: inline
In-Reply-To: <20080627120050.500232841@saeurebad.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Johannes Weiner <hannes@saeurebad.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Fri, Jun 27, 2008 at 01:54:07PM +0200, Johannes Weiner wrote:
> Remove arch-specific show_mem() in favor of the generic version.

Still looks good for UML.

      	    	 Jeff

-- 
Work email - jdike at linux dot intel dot com

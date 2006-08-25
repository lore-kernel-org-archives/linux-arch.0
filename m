Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from holomorphy.com ([66.93.40.71]:53726 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S1422790AbWHYAcC (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 24 Aug 2006 20:32:02 -0400
Date: Thu, 24 Aug 2006 17:32:00 -0700
From: William Lee Irwin III <wli@holomorphy.com>
Subject: Re: [RFC][PATCH] unify all architecture PAGE_SIZE definitions
Message-ID: <20060825003200.GF3580@holomorphy.com>
References: <20060824234445.6B519D52@localhost.localdomain> <20060824235806.GD3580@holomorphy.com> <1156464441.12011.151.camel@localhost.localdomain> <20060825001459.GE3580@holomorphy.com> <1156465424.12011.159.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1156465424.12011.159.camel@localhost.localdomain>
Sender: linux-arch-owner@vger.kernel.org
To: Dave Hansen <haveblue@us.ibm.com>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Thu, Aug 24, 2006 at 05:23:44PM -0700, Dave Hansen wrote:
> Is it the Kconfig names themselves which you don't like?  I guess it is
> a bit silly to have CONFIG_PAGE_SIZE_X, defined to be number Y, which is
> then calculated back to being X again.  But, we were really already
> doing that (in three places):

An integer define would do. Then again, it occurs to me this might be
some sort of garbage so one can write "4KB," "8KB," etc. on the menus
presented to the users.


-- wli

Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:47473 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932263AbaFYUmh (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 25 Jun 2014 16:42:37 -0400
Date: Wed, 25 Jun 2014 13:42:35 -0700
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 0/6] RCU get_user_pages_fast and __get_user_pages_fast
Message-ID: <20140625134235.4f32768faa1a4380a62458ff@linux-foundation.org>
In-Reply-To: <1403710824-24340-1-git-send-email-steve.capper@linaro.org>
References: <1403710824-24340-1-git-send-email-steve.capper@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Steve Capper <steve.capper@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com, linux@arm.linux.org.uk, linux-arch@vger.kernel.org, linux-mm@kvack.org, will.deacon@arm.com, gary.robertson@linaro.org, christoffer.dall@linaro.org, peterz@infradead.org, anders.roxell@linaro.org
Message-ID: <20140625204235.goe4O8GJz1Hfa7UBT9GJ4i-oX5zlNFnn7LraHg3IZLg@z>

On Wed, 25 Jun 2014 16:40:18 +0100 Steve Capper <steve.capper@linaro.org> wrote:

> This series implements general forms of get_user_pages_fast and
> __get_user_pages_fast and activates them for arm and arm64.

Why not x86?

I think I might have already asked this.  If so, it's your fault for
not updating the changelog ;)

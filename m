Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:41500 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932352AbdHVK0p (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 22 Aug 2017 06:26:45 -0400
Date: Tue, 22 Aug 2017 11:25:28 +0100
From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 0/2] Fatal signal handing within uaccess faults
Message-ID: <20170822102527.GA14671@leverpostej>
References: <1499782590-31366-1-git-send-email-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1499782590-31366-1-git-send-email-mark.rutland@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arm-kerne@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: catalin.marinas@arm.com, james.morse@arm.com, labbott@redhat.com, linux@armlinux.org.uk, stable@vger.kernel.org, steve.capper@arm.com, will.deacon@arm.com, viro@zeniv.linux.org.uk, peterz@infradead.org, luto@amacapital.net
Message-ID: <20170822102528.wXjOrPvw8nPzJXZLFa4DEBbw8bTK5IREyAKa0DldHx4@z>

On Tue, Jul 11, 2017 at 03:16:28PM +0100, Mark Rutland wrote:
> Hi,
> 
> Arch maintainer tl;dr: most arch fault code doesn't handle fatal signals
> correctly, allowing unprivileged users to create an unkillable task which can
> lock up the system. Please check whether your arch is affected.

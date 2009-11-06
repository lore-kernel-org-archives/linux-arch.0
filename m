From: Kyle McMartin <kyle@mcmartin.ca>
Subject: Re: [PATCH 06/11] sysctl: parisc Use the compat_sys_sysctl
Date: Fri, 6 Nov 2009 01:01:54 -0500
Message-ID: <20091106060154.GE11702@bombadil.infradead.org>
References: <m1tyx8trik.fsf@fess.ebiederm.org> <1257468114-6823-6-git-send-email-ebiederm@xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([18.85.46.34]:53154 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754869AbZKFGBu (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 6 Nov 2009 01:01:50 -0500
Content-Disposition: inline
In-Reply-To: <1257468114-6823-6-git-send-email-ebiederm@xmission.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Kyle McMartin <kyle@mcmartin.ca>, Thibaut Varene <T-Bone@parisc-linux.org>

On Thu, Nov 05, 2009 at 04:41:49PM -0800, Eric W. Biederman wrote:
> From: Eric W. Biederman <ebiederm@xmission.com>
> 
> Now that we have a generic 32bit compatibility implementation
> there is no need for parisc to implement it's own.
> 
> Cc: Kyle McMartin <kyle@mcmartin.ca>
> Cc: Thibaut Varene <T-Bone@parisc-linux.org>
> Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>

Acked-by: Kyle McMartin <kyle@mcmartin.ca>

From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [RFC PATCH v1 40/40] fs: dafs: Add DAFS filesystem for metag
Date: Wed, 31 Oct 2012 16:42:38 +0000
Message-ID: <20121031164238.GJ2616@ZenIV.linux.org.uk>
References: <1351700061-7203-1-git-send-email-james.hogan@imgtec.com>
 <1351700061-7203-41-git-send-email-james.hogan@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:36103 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757913Ab2JaQmj (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 31 Oct 2012 12:42:39 -0400
Content-Disposition: inline
In-Reply-To: <1351700061-7203-41-git-send-email-james.hogan@imgtec.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James Hogan <james.hogan@imgtec.com>
Cc: linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org

On Wed, Oct 31, 2012 at 04:14:21PM +0000, James Hogan wrote:
> +static int fserrno;

... and nothing visible serializing its users.  AFAICS, there's nothing
stopping one thread from doing this fscall thing, then deciding to check
what's in fserrno only to find that *another* thread has also done
fscall - a different one, with different results and different value
stored in fserrno.

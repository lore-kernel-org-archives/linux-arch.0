Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:45542 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751352AbeBTNq2 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 20 Feb 2018 08:46:28 -0500
Date: Tue, 20 Feb 2018 14:46:23 +0100
From: Michal Hocko <mhocko@kernel.org>
Subject: Re: [RESEND][PATCH 0/3] exec: Pin stack limit during exec
Message-ID: <20180220134623.GA21134@dhcp22.suse.cz>
References: <1518638796-20819-1-git-send-email-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1518638796-20819-1-git-send-email-keescook@chromium.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Ben Hutchings <ben@decadent.org.uk>, Willy Tarreau <w@1wt.eu>, Hugh Dickins <hughd@google.com>, Oleg Nesterov <oleg@redhat.com>, "Jason A. Donenfeld" <Jason@zx2c4.com>, Rik van Riel <riel@redhat.com>, Laura Abbott <labbott@redhat.com>, Greg KH <greg@kroah.com>, Andy Lutomirski <luto@kernel.org>, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com
Message-ID: <20180220134623.fAgMS0fpZPOj6fbsBNnUVNBJMRghL_95vgkBWWioq3Q@z>

On Wed 14-02-18 12:06:33, Kees Cook wrote:
> Attempts to solve problems with the stack limit changing during exec
> continue to be frustrated[1][2]. In addition to the specific issues around
> the Stack Clash family of flaws, Andy Lutomirski pointed out[3] other
> places during exec where the stack limit is used and is assumed to be
> unchanging. Given the many places it gets used and the fact that it can be
> manipulated/raced via setrlimit() and prlimit(), I think the only way to
> handle this is to move away from the "current" view of the stack limit and
> instead attach it to the bprm, and plumb this down into the functions that
> need to know the stack limits. This series implements the approach.
> 
> Neither I nor 0-day have found issues with this series, so I'd like to
> get it into -mm for further testing.

Sorry, for the late response. All three patches make sense to me.
finalize_exec could see a much better documentation and explain what is
the semantic.

Anyway, feel free to add
Acked-by: Michal Hocko <mhocko@suse.com>
-- 
Michal Hocko
SUSE Labs

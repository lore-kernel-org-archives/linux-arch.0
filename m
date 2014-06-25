From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 0/6] RCU get_user_pages_fast and __get_user_pages_fast
Date: Wed, 25 Jun 2014 13:42:35 -0700
Message-ID: <20140625134235.4f32768faa1a4380a62458ff@linux-foundation.org>
References: <1403710824-24340-1-git-send-email-steve.capper@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <1403710824-24340-1-git-send-email-steve.capper@linaro.org>
Sender: owner-linux-mm@kvack.org
To: Steve Capper <steve.capper@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com, linux@arm.linux.org.uk, linux-arch@vger.kernel.org, linux-mm@kvack.org, will.deacon@arm.com, gary.robertson@linaro.org, christoffer.dall@linaro.org, peterz@infradead.org, anders.roxell@linaro.org
List-Id: linux-arch.vger.kernel.org

On Wed, 25 Jun 2014 16:40:18 +0100 Steve Capper <steve.capper@linaro.org> wrote:

> This series implements general forms of get_user_pages_fast and
> __get_user_pages_fast and activates them for arm and arm64.

Why not x86?

I think I might have already asked this.  If so, it's your fault for
not updating the changelog ;)

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>

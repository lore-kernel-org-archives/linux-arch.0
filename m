From: Max Filippov <jcmvbkbc@gmail.com>
Subject: Re: [REVIEW][PATCH 22/22] signal/xtensa: Use force_sig_fault where appropriate
Date: Fri, 20 Apr 2018 09:27:35 -0700
Message-ID: <CAMo8Bf+LhSQX=debxSBLzpESb1LojBVdPd+L4x1ax5mBVvvYMA@mail.gmail.com>
References: <87604mhrnb.fsf@xmission.com> <20180420143811.9994-22-ebiederm@xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180420143811.9994-22-ebiederm@xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Chris Zankel <chris@zankel.net>, linux-xtensa@linux-xtensa.org
List-Id: linux-arch.vger.kernel.org

On Fri, Apr 20, 2018 at 7:38 AM, Eric W. Biederman
<ebiederm@xmission.com> wrote:
> Filling in struct siginfo before calling force_sig_info a tedious and
> error prone process, where once in a great while the wrong fields
> are filled out, and siginfo has been inconsistently cleared.
>
> Simplify this process by using the helper force_sig_fault.  Which
> takes as a parameters all of the information it needs, ensures
> all of the fiddly bits of filling in struct siginfo are done properly
> and then calls force_sig_info.
>
> In short about a 5 line reduction in code for every time force_sig_info
> is called, which makes the calling function clearer.
>
> Cc: Max Filippov <jcmvbkbc@gmail.com>
> Cc: Chris Zankel <chris@zankel.net>
> Cc: linux-xtensa@linux-xtensa.org
> Cc: linux-xtensa@linux-xtensa.org
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> ---
>  arch/xtensa/kernel/traps.c | 10 +---------
>  arch/xtensa/mm/fault.c     | 19 +++++--------------
>  2 files changed, 6 insertions(+), 23 deletions(-)

Acked-by: Max Filippov <jcmvbkbc@gmail.com>

-- 
Thanks.
-- Max

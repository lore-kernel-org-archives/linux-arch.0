From: Pekka Enberg <penberg@kernel.org>
Subject: Re: [PATCH] mm: add sys_madvise2 and MADV_NAME to name vmas
Date: Sat, 06 Jul 2013 09:33:05 +0300
Message-ID: <51D7BA21.4030105@kernel.org>
References: <1372901537-31033-1-git-send-email-ccross@android.com> <87txkaq600.fsf@xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <87txkaq600.fsf@xmission.com>
Sender: owner-linux-mm@kvack.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Colin Cross <ccross@android.com>, linux-kernel@vger.kernel.org, Kyungmin Park <kmpark@infradead.org>, Christoph Hellwig <hch@infradead.org>, John Stultz <john.stultz@linaro.org>, Rob Landley <rob@landley.net>, Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, Cyrill Gorcunov <gorcunov@openvz.org>, David Rientjes <rientjes@google.com>, Davidlohr Bueso <dave@gnu.org>, Kees Cook <keescook@chromium.org>, Al Viro <viro@zeniv.linux.org.uk>, Hugh Dickins <hughd@google.com>, Mel Gorman <mgorman@suse.de>, Michel Lespinasse <walken@google.com>, Rik van Riel <riel@redhat.com>, Konstantin Khlebnikov <khlebnikov@openvz.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Rusty Russell <rusty@rustcorp.com.au>, Oleg Nesterov <oleg@redhat.com>, Srikar Dronamraju <srikar@linux.vnet.ibm.com>, KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>, Michal Hocko <mhocko@s>
List-Id: linux-arch.vger.kernel.org

On 7/4/13 7:54 AM, Eric W. Biederman wrote:
> How can adding glittler to /proc/<pid>/maps and /proc/<pid>/smaps
> justify putting a hand break on the linux kernel?

It's not just glitter, it's potentially very useful for making
perf work nicely with JVM, for example, to know about JIT
codegen regions and GC regions.

The implementation seems very heavy-weight though and I'm not
convinced a new syscall makes sense.

			Pekka

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>

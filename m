From: Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH] mm: add sys_madvise2 and MADV_NAME to name vmas
Date: Wed, 10 Jul 2013 17:19:14 -0700
Message-ID: <51DDFA02.9040707@intel.com>
References: <1372901537-31033-1-git-send-email-ccross@android.com> <51DDE974.6060200@intel.com> <CAMbhsRTio2mS=azWTxSdRdaZJRRf5FfMNoQUZmrFjkB7kv9LSQ@mail.gmail.com> <51DDF071.5000309@intel.com> <CAMbhsRTs45QE1ze6mvdiL2QYKD0dHjXoRk7o1h2Y_rYP80ckDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <CAMbhsRTs45QE1ze6mvdiL2QYKD0dHjXoRk7o1h2Y_rYP80ckDg@mail.gmail.com>
Sender: owner-linux-mm@kvack.org
To: Colin Cross <ccross@android.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Kyungmin Park <kmpark@infradead.org>, Christoph Hellwig <hch@infradead.org>, John Stultz <john.stultz@linaro.org>, Rob Landley <rob@landley.net>, Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, Cyrill Gorcunov <gorcunov@openvz.org>, David Rientjes <rientjes@google.com>, Davidlohr Bueso <dave@gnu.org>, Kees Cook <keescook@chromium.org>, Al Viro <viro@zeniv.linux.org.uk>, Hugh Dickins <hughd@google.com>, Mel Gorman <mgorman@suse.de>, Michel Lespinasse <walken@google.com>, Rik van Riel <riel@redhat.com>, Konstantin Khlebnikov <khlebnikov@openvz.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Rusty Russell <rusty@rustcorp.com.au>, "Eric W. Biederman" <ebiederm@xmission.com>, Oleg Nesterov <oleg@redhat.com>, Srikar Dronamraju <srikar@linux.vnet.ibm.com>, KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>Mic
List-Id: linux-arch.vger.kernel.org

On 07/10/2013 05:12 PM, Colin Cross wrote:
> I wonder if it
> would be worth trying to make names a struct file?  They would be
> significantly larger than a struct vma_name, but reuse all the
> existing refcounting code.

Not worth it INMHO.

>> Here's one more idea: instead of having a kernel pointer, let's let
>> userspace hand the kernel a userspace address, and the kernel will hang
>> on to it.  Userspace is responsible for keeping it valid, kind of like
>> ARGV[].  When the kernel goes to dump out the /proc/$pid/maps fields, it
>> can do a copy_from_user() to get the string back out.  If this fails, it
>> can just go and treat it like a non-named VMA, or could output
>> "userspace sucks".
>>
>> That way, the kernel isn't dealing with refcounting and allocating
>> strings.  It's got security concerns, just like
>> /proc/$pid/cmdline since it'll let you dig around in another process's
>> address space via /proc.  But, I think they're manageable.
> 
> How do you deal with merging adjacent vmas with the same name?  The
> whole point of the refcounted strings is to allow comparing strings
> for equality by comparing pointers.  You could say that a named vma
> never gets merged, but then you might as well use separate tmpfs
> files, and you end up at least doubling the number of vmas in some
> processes I've seen.

If they have the same userspace pointer target, then they get merged.
Two adjacent vmas with the same name (according to strcmp()) would not
get merged.

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>

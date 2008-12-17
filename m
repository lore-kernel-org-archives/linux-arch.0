From: Dan Mick <dan.mick-xsfywfwIY+M@public.gmane.org>
Subject: Re: [PATCH v2] Add preadv and pwritev system calls.
Date: Tue, 16 Dec 2008 17:45:45 -0800
Message-ID: <494859C9.20305@sun.com>
References: <1229090440-32120-1-git-send-email-kraxel@redhat.com>
	<67079b830812150837o12adaa1awe40b0759bbea1f7a@mail.gmail.com>
	<4946C160.2090505@redhat.com> <200812161057.03025.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <opensolaris-code-bounces-xZgeD5Kw2fzokhkdeNNY6A@public.gmane.org>
In-Reply-To: <200812161057.03025.arnd-r2nGTMty4D4@public.gmane.org>
List-Unsubscribe: <http://mail.opensolaris.org/mailman/listinfo/opensolaris-code>,
	<mailto:opensolaris-code-request-xZgeD5Kw2fzokhkdeNNY6A@public.gmane.org?subject=unsubscribe>
List-Archive: <http://mail.opensolaris.org/pipermail/opensolaris-code>
List-Post: <mailto:opensolaris-code-xZgeD5Kw2fzokhkdeNNY6A@public.gmane.org>
List-Help: <mailto:opensolaris-code-request-xZgeD5Kw2fzokhkdeNNY6A@public.gmane.org?subject=help>
List-Subscribe: <http://mail.opensolaris.org/mailman/listinfo/opensolaris-code>,
	<mailto:opensolaris-code-request-xZgeD5Kw2fzokhkdeNNY6A@public.gmane.org?subject=subscribe>
Sender: opensolaris-code-bounces-xZgeD5Kw2fzokhkdeNNY6A@public.gmane.org
Errors-To: opensolaris-code-bounces-xZgeD5Kw2fzokhkdeNNY6A@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Matthew Wilcox <matthew-Ztpu424NOJ8@public.gmane.org>, opensolaris-code-xZgeD5Kw2fzokhkdeNNY6A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, opensolaris-rfe-xZgeD5Kw2fzokhkdeNNY6A@public.gmane.org, Gerd Hoffmann <kraxel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Ulrich Drepper <drepper-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: linux-arch.vger.kernel.org

Arnd Bergmann wrote:
> On Monday 15 December 2008, Gerd Hoffmann wrote:
>> Jennifer Pioch wrote:
>>> On 12/12/08, Gerd Hoffmann <kraxel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
>>>> Free- and OpenBSD have it too.  For Solaris I've found a feature request
>>>>  only.  Dunno about MacOS/Darwin.  Other un*xes which are important these
>>>>  days?
>>> Do you know the ID of the feature request?
>> #1167819 @ bugs.opensolaris.org
>>
> 
> Looks like they've been working on it for some time:
> "Submit Date   25-MAY-1994"!
> 
> 	Arnd <><

No one's expended any serious time on it at all, it looks like, other than 
discussion.

I see the one comment says that it can be done with lio_listio(3RT) (apparently 
in LIO_WAIT mode), and that interface does seem to offer all the preadv/pwritev
functionality.  That's not to say that we shouldn't implement preadv/pwritev 
literally, just that there should be a way to get that sort of functionality today.

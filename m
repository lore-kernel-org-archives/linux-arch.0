From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [GIT PULL] use generic pci_iomap on all architectures
Date: Tue, 10 Jan 2012 18:38:58 -0800
Message-ID: <7vipkj7ykd.fsf@alter.siamese.dyndns.org>
References: <20120105145836.GA2751@redhat.com>
 <20120106083141.9c14a8d2d09539c6a6c0db75@canb.auug.org.au>
 <20120106083916.9588034bde22a6803e327aa9@canb.auug.org.au>
 <20120106084701.8f704542754db826deda318a@canb.auug.org.au>
 <CA+55aFwXj2ELrTDSgFfSC2Usz99-24uFSznAP34feJiCttwayQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51118 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933596Ab2AKCjB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 10 Jan 2012 21:39:01 -0500
In-Reply-To: <CA+55aFwXj2ELrTDSgFfSC2Usz99-24uFSznAP34feJiCttwayQ@mail.gmail.com> (Linus
 Torvalds's message of "Tue, 10 Jan 2012 17:51:07 -0800")
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Git Mailing List <git@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Jesse Barnes <jbarnes@virtuousgeek.org>, Andrew Morton <akpm@linux-foundation.org>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Thu, Jan 5, 2012 at 1:47 PM, Stephen Rothwell <sfr@canb.auug.org.a=
u> wrote:
>> On Fri, 6 Jan 2012 08:39:16 +1100 Stephen Rothwell <sfr@canb.auug.or=
g.au> wrote:
>>>
>>> So why does you pull request refer to "commit
>>> 805a6af8dba5dfdd35ec35dc52ec0122400b2610", I wonder? =C2=A0Is that =
just what
>>> "git request-pull" produced?
>>
>> I see, "git request-pull" just puts in whatever you specify on the
>> command line rather than the merge-base ...
>
> .. and that is a fairly silly misfeature, since it makes the "since
> commit xyz" largely meaningless.
>
> I suspect we really should make "git request-pull" show the merge
> base(s) as the "since commit", because that way the output of git
> request-pull is "stable", and doesn't depend on what particular rando=
m
> state you've synced up to since.
>
> Junio, I think the patch would be as simple as the attached - totally
> untested - one-liner? Comments?

I think it makes sense.

We use whatever garbage the user gave us (e.g. "origin/linus" which may
have been updated since the topic forked and be made irrelevant) only t=
o
figure out where the history forked, and once we find that out we
consistently use the fork-point which has some meaning.

The parameter to "git shortlog" that appears later should also be updat=
ed
to match this, by the way, even though that should not affect the outco=
me
in any way.

I am however not sure what would happen when there are more than one me=
rge
bases. I guess those who throw pull requests are not supposed to be doi=
ng
merges in reverse direction, so it should not matter ;-)

 git-request-pull.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-request-pull.sh b/git-request-pull.sh
index d7ba117..38b68bb 100755
--- a/git-request-pull.sh
+++ b/git-request-pull.sh
@@ -96,7 +96,7 @@ git show -s --format=3D'The following changes since c=
ommit %H:
   %s (%ci)
=20
 are available in the git repository at:
-' $baserev &&
+' $merge_base &&
 echo "  $url${ref+ $ref}" &&
 git show -s --format=3D'
 for you to fetch changes up to %H:
@@ -124,7 +124,7 @@ then
 	echo "---------------------------------------------------------------=
-"
 fi &&
=20
-git shortlog ^$baserev $headrev &&
+git shortlog $merge_base..$headrev &&
 git diff -M --stat --summary $patch $merge_base..$headrev || status=3D=
1
=20
 if test -z "$ref"

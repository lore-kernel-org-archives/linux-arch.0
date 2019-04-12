From: Markus Heiser <markus.heiser@darmarit.de>
Subject: Re: [PATCH 0/8] Prepare files under Documentation/*.txt to build with
 Sphinx
Date: Fri, 12 Apr 2019 18:45:42 +0200
Message-ID: <06b2aeb4-825a-28d6-fa7d-f1f5900e53d8@darmarit.de>
References: <94c47f05-0412-b938-908d-1ef8a91243ed@darmarit.de>
 <cover.1554889999.git.mchehab+samsung@kernel.org>
 <18261.1555064496@warthog.procyon.org.uk>
 <27303.1555071586@warthog.procyon.org.uk>
 <df609cad-fa5b-ac15-314f-ac8759771d90@darmarit.de>
 <20190412093947.62913186@lwn.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190412093947.62913186@lwn.net>
Content-Language: de-DE
Sender: linux-kernel-owner@vger.kernel.org
To: Jonathan Corbet <corbet@lwn.net>
Cc: David Howells <dhowells@redhat.com>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Linux Doc Mailing List <linux-doc@vger.kernel.org>, Mauro Carvalho Chehab <mchehab@infradead.org>, linux-kernel@vger.kernel.org, Andrea Parri <andrea.parri@amarulasolutions.com>, Nicholas Piggin <npiggin@gmail.com>, linux-arch@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>, Luc Maranget <luc.maranget@inria.fr>, Alan Stern <stern@rowland.harvard.edu>, Akira Yokosawa <akiyks@gmail.com>, Will Deacon <will.deacon@arm.com>, "Paul E. McKenney" <paulmck@linux.ibm.com>, Daniel Lustig <dlustig@nvidia.com>, Jade Alglave <j.alglave@ucl.ac.uk>
List-Id: linux-arch.vger.kernel.org


Am 12.04.19 um 17:39 schrieb Jonathan Corbet:
> On Fri, 12 Apr 2019 14:34:25 +0200
> Markus Heiser <markus.heiser@darmarit.de> wrote:
> 
>> Am 12.04.19 um 14:19 schrieb David Howells:
>>> Markus Heiser <markus.heiser@darmarit.de> wrote:
>>>    
>>>> Which is already named in our 'How to write kernel documentation' introduction
>>>>
>>>> - https://www.kernel.org/doc/html/latest/doc-guide/sphinx.html#writing-documentation
>>>
>>> This should really be in Documentation/ directory.
>>>    
>>
>> I agree with you, it is a kind of information hiding.  If you know proper
>> places, please send a patch to Jon.
> 
> As Jani pointed out, it's in Documentation/doc-guide.
> 
> If you're saying it should be in the top level, I kind of disagree.
> Documentation/ is an exercise in hiding information by placing it in the
> middle of 200 other, unrelated files.  We've made some progress on that,
> and I would like to continue to do so.

For those who are new and are willing to document, it migth be a good idea
to have a simple Documentation/README.txt  with a link to doc-guide?

Just a few words, I find with my editor, this is what I find often helpful
when I'am new to a project.

-- Markus --

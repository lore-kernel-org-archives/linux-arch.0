From: Akira Yokosawa <akiyks@gmail.com>
Subject: Re: [PATCH memory-model 0/3] Updates to the formal memory model
Date: Wed, 5 Dec 2018 00:40:01 +0900
Message-ID: <fbd7b1ed-7a4f-b877-e2f0-8dafca817f68@gmail.com>
References: <20181203230411.GA27476@linux.ibm.com>
 <802d5c17-74fd-86a1-efba-5ee2825a0c3c@gmail.com>
 <20181203235127.GS4170@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181203235127.GS4170@linux.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: paulmck@linux.ibm.com
Cc: mingo@kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, stern@rowland.harvard.edu, parri.andrea@gmail.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr
List-Id: linux-arch.vger.kernel.org

On 2018/12/03 15:51:27 -0800, Paul E. McKenney wrote:
> On Tue, Dec 04, 2018 at 08:28:03AM +0900, Akira Yokosawa wrote:
>> On 2018/12/03 15:04:11 -0800, Paul E. McKenney wrote:
>>> Hello, Ingo!
>>>
>>> This series contains updates to the Linux kernel's formal memory model
>>> in tools/memory-model.  These patches are ready for inclusion into -tip.
>>>
>>> 1.	Model smp_mb__after_unlock_lock(), courtesy of Andrea Parri.
>>>
>>> 2.	Add scripts to check github litmus tests.
>>>
>>> 3.	Make scripts take "-j" abbreviation for "--jobs".
>>>
>>> There is another series in preparation to model SRCU, but this series
>>> requires hot-off-the presses changes to the herd tool that have not yet
>>> been released.  This SRCU series is therefore targeting the merge window
>>> after the upcoming one.  People wishing to experiment with the prototype
>>> SRCU model may obtain it from my -rcu tree at branch "dev", and use
>>> a bleeding-edge herd7 built from https://github.com/herd/herdtools7/,
>>> version 7.51+2(dev), which is (commit 10403b24070c) or later.
>>
>> On the master branch of herdtools7, SRCU support was added in version
>> 7.51+4(dev), which is commit 6ec9da1f4d58, or later.
> 
> It has been working for me with version 7.51+2(dev), but perhaps I
> have just been getting lucky.  It wouldn't be the first time!  ;-)

Sounds like you've been at the HEAD of topic branch "srcu".

        Thanks, Akira
> 
> 							Thanx, Paul
> 
>>         Thanks, Akira
>>
>>>
>>> 							Thanx, Paul
>>>
>>> ------------------------------------------------------------------------
>>>
>>>  .gitignore                 |    1 
>>>  README                     |    2 
>>>  linux-kernel.bell          |    3 
>>>  linux-kernel.cat           |    4 -
>>>  linux-kernel.def           |    1 
>>>  scripts/README             |   70 ++++++++++++++++++++++
>>>  scripts/checkalllitmus.sh  |   53 +++++++----------
>>>  scripts/checkghlitmus.sh   |   65 ++++++++++++++++++++
>>>  scripts/checklitmus.sh     |   74 +++--------------------
>>>  scripts/checklitmushist.sh |   60 +++++++++++++++++++
>>>  scripts/cmplitmushist.sh   |   87 +++++++++++++++++++++++++++
>>>  scripts/initlitmushist.sh  |   68 +++++++++++++++++++++
>>>  scripts/judgelitmus.sh     |   78 +++++++++++++++++++++++++
>>>  scripts/newlitmushist.sh   |   61 +++++++++++++++++++
>>>  scripts/parseargs.sh       |  140 ++++++++++++++++++++++++++++++++++++++++++++-
>>>  scripts/runlitmushist.sh   |   87 +++++++++++++++++++++++++++
>>>  16 files changed, 757 insertions(+), 97 deletions(-)
>>>
>>
> 

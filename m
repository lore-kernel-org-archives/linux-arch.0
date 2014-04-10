From: Thomas Hellstrom <thellstrom@vmware.com>
Subject: Re: [PATCH 2/2] [RFC] reservation: add suppport for read-only access
 using rcu
Date: Thu, 10 Apr 2014 13:25:23 +0200
Message-ID: <53467FA3.5040805@vmware.com>
References: <20140409144239.26648.57918.stgit@patser>
 <20140409144831.26648.79163.stgit@patser> <53465A53.1090500@vmware.com>
 <53466D63.8080808@canonical.com> <53467B93.3000402@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <53467B93.3000402@vmware.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Maarten Lankhorst <maarten.lankhorst@canonical.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, ccross@google.com, linux-media@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On 04/10/2014 01:08 PM, Thomas Hellstrom wrote:
> On 04/10/2014 12:07 PM, Maarten Lankhorst wrote:
>> Hey,
>>
>> op 10-04-14 10:46, Thomas Hellstrom schreef:
>>> Hi!
>>>
>>> Ugh. This became more complicated than I thought, but I'm OK with moving
>>> TTM over to fence while we sort out
>>> how / if we're going to use this.
>>>
>>> While reviewing, it struck me that this is kind of error-prone, and hard
>>> to follow since we're operating on a structure that may be
>>> continually updated under us, needing a lot of RCU-specific macros and
>>> barriers.
>> Yeah, but with the exception of dma_buf_poll I don't think there is
>> anything else
>> outside drivers/base/reservation.c has to deal with rcu.
>>
>>> Also the rcu wait appears to not complete until there are no busy fences
>>> left (new ones can be added while we wait) rather than
>>> waiting on a snapshot of busy fences.
>> This has been by design, because 'wait for bo idle' type of functions
>> only care
>> if the bo is completely idle or not.
> No, not when using RCU, because the bo may be busy again before the
> function returns :)
> Complete idleness can only be guaranteed if holding the reservation, or
> otherwise making sure
> that no new rendering is submitted to the buffer, so it's an overkill to
> wait for complete idleness here.
>
Although, if we fail to get a refcount for a fence, and it's still busy
we need to do  a seq retry,
because the fence might have been replaced by another fence from the
same context, without being idle. That check is not present in the
snapshot code I sent.

/Thomas

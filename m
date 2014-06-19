From: Sumit Semwal <sumit.semwal@linaro.org>
Subject: Re: [REPOST PATCH 1/8] fence: dma-buf cross-device synchronization
 (v17)
Date: Thu, 19 Jun 2014 10:56:15 +0530
Message-ID: <CAO_48GE8t0zT2p=JCYvgYPQKhw6QiGEA-ufzKqZUirQLQs+nqw@mail.gmail.com>
References: <20140618102957.15728.43525.stgit@patser>
 <20140618103653.15728.4942.stgit@patser>
 <20140619011653.GF10921@kroah.com>
 <CAF6AEGtzv0+PoMwSfK=NTYAO=bxsnS2BcwLxLNmLqnGTEUV8ng@mail.gmail.com>
 <CAO_48GF_hb5PZFwEmx8vsy+gW=Mq=cnEq8H4W74hCdz9qg0+SQ@mail.gmail.com>
 <20140619045438.GA14497@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20140619045438.GA14497@kroah.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-arch <linux-arch@vger.kernel.org>, Thomas Hellstrom <thellstrom@vmware.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>, Colin Cross <ccross@google.com>, "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On 19 June 2014 10:24, Greg KH <gregkh@linuxfoundation.org> wrote:
> On Thu, Jun 19, 2014 at 09:57:35AM +0530, Sumit Semwal wrote:
>> Hi Greg,
>>

>> >>
>> >> Who is going to sign up to maintain this code?  (hint, it's not me...)
>> >
>> > that would be Sumit (dma-buf tree)..
>> >
>> > probably we should move fence/reservation/dma-buf into drivers/dma-buf
>> > (or something approximately like that)
>> Yes, that would be me - it might be better to create a new directory
>> as suggested above (drivers/dma-buf).
>
> That's fine with me, there is going to be more than just one file in
> there, right?  :)
>
> greg k-h
Certainly atleast 3 :)

~sumit

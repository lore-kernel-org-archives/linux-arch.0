From: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 6/6] s390x: Mark archrandom.h functions __must_check
Date: Tue, 29 Oct 2019 14:18:33 +0100
Message-ID: <cd6b5b8c-77f0-ad7e-702a-27e5a929ca54@linaro.org>
References: <20191028210559.8289-1-rth@twiddle.net>
 <20191028210559.8289-7-rth@twiddle.net>
 <935cf73a-d06c-365d-131a-23dcb350ba17@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <935cf73a-d06c-365d-131a-23dcb350ba17@linux.ibm.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Harald Freudenberger <freude@linux.ibm.com>, linux-arch@vger.kernel.org
Cc: linux-s390@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>, x86@kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

On 10/29/19 8:26 AM, Harald Freudenberger wrote:
> Fine with me, Thanks, reviewed, build and tested.
> You may add my reviewed-by: Harald Freudenberger <freude@linux.ibm.com>
> However, will this go into the kernel tree via crypto or s390 subsystem ?

That's an excellent question.

As an API decision, perhaps going via crypto makes more sense,
but none of the patches are dependent on one another, so they
could go through separate architecture trees.

It has been a long time since I have done much kernel work;
I'm open to suggestions on the subject.


r~

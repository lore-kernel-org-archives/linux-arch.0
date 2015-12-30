From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 07/34] sparc: reuse asm-generic/barrier.h
Date: Wed, 30 Dec 2015 21:55:33 +0200
Message-ID: <20151230215303-mutt-send-email-mst@redhat.com>
References: <1451473761-30019-1-git-send-email-mst@redhat.com>
	<1451473761-30019-8-git-send-email-mst@redhat.com>
	<20151230.125603.75638711551088484.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20151230.125603.75638711551088484.davem@davemloft.net>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: David Miller <davem@davemloft.net>
Cc: linux-arch@vger.kernel.org, arnd@arndb.de, stefano.stabellini@eu.citrix.com, peterz@infradead.org, andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org, andreyknvl@google.com, virtualization@lists.linux-foundation.org, mpe@ellerman.id.au, sparclinux@vger.kernel.org, mingo@kernel.org
List-Id: linux-arch.vger.kernel.org

On Wed, Dec 30, 2015 at 12:56:03PM -0500, David Miller wrote:
> 
> I find it a little bit irritating when I receive a patch directly
> addressed to me to review, but I don't see the "00/34" cover letter.
> 
> I want to see what this series is about, and what the motiviation
> for this change is.
> 
> I'm also highly frustrated, in general, with mix-and-match CC: lists
> for patch series.  Just put everyone relevant in the CC: for the
> entire series.  That way I can easily inspect other parts of the
> series to see infrastructure buildup, and examples of other
> conversions or versions of the change.
> 
> Thanks.

Hi Dave.
Sorry about that.

The problem I had in the past is that vger rejects email with
too many CC addresses.

(It also rejected email with __smp_XXX in the subject
suspecting it's spam :( )

I'll look for better solutions next time - for now, would it help if I
bounced the whole patchset to you?

-- 
MST

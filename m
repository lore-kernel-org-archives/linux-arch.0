From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 4/4] powerpc: Allow LD_DEAD_CODE_DATA_ELIMINATION to be
 selected
Date: Fri, 20 Apr 2018 20:41:04 +1000
Message-ID: <20180420204104.6e22b136@roar.ozlabs.ibm.com>
References: <20180420073414.23169-1-npiggin@gmail.com>
 <20180420073414.23169-5-npiggin@gmail.com>
 <CA+7wUswuyn+YgNe732rQAzVmgDBohTMEqwsd76nQ_CH5h7Y5WA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <CA+7wUswuyn+YgNe732rQAzVmgDBohTMEqwsd76nQ_CH5h7Y5WA@mail.gmail.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
To: Mathieu Malaterre <malat@debian.org>
Cc: linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Nicolas Pitre <nico@fluxnic.net>
List-Id: linux-arch.vger.kernel.org

On Fri, 20 Apr 2018 12:00:49 +0200
Mathieu Malaterre <malat@debian.org> wrote:

> On Fri, Apr 20, 2018 at 9:34 AM, Nicholas Piggin <npiggin@gmail.com> wrote:
> > This requires further changes to linker script to KEEP some tables
> > and wildcard compiler generated sections into the right place. This
> > includes pp32 modifications from Christophe Leroy.
> >
> > When compiling powernv_defconfig with this option:
> >
> > text       data      bss       dec        filename
> > 11827621   4810490   1341080   17979191   vmlinux
> > 11752437   4598858   1338776   17690071   vmlinux.dcde
> >
> > Resulting kernel is almost 400kB smaller (and still boots).
> >
> > [ppc32 numbers here]  
> 
> ^^^
> 
> Do you want somebody else to provide those numbers ?

If you have a booting kernel, yes some more numbers would be good.

Thanks,
Nick

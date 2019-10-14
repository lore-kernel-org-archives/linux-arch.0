From: Max Filippov <jcmvbkbc@gmail.com>
Subject: Re: [PATCH v2 25/29] xtensa: Move EXCEPTION_TABLE to RO_DATA segment
Date: Mon, 14 Oct 2019 00:41:06 -0700
Message-ID: <CAMo8BfKexMmMusB3XOeaMOZHdU4ccz+PMGA=Jy+KQhgD8H_8UQ@mail.gmail.com>
References: <20191011000609.29728-1-keescook@chromium.org>
 <20191011000609.29728-26-keescook@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20191011000609.29728-26-keescook@chromium.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Kees Cook <keescook@chromium.org>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Michal Simek <monstr@monstr.eu>, "maintainer:X86 ARCHITECTURE..." <x86@kernel.org>, "open list:IA64 (Itanium) PL..." <linux-ia64@vger.kernel.org>, linux-c6x-dev@linux-c6x.org, Arnd Bergmann <arnd@arndb.de>, "open list:TENSILICA XTENSA PORT (xtensa)" <linux-xtensa@linux-xtensa.org>, Michael Ellerman <mpe@ellerman.id.au>, Dave Hansen <dave.hansen@linux.intel.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linuxppc-dev@lists.ozlabs.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Borislav Petkov <bp@alien8.de>, "open list:PARISC ARCHITECTURE" <linux-parisc@vger.kernel.org>, Andy Lutomirski <luto@kernel.org>, "open list:ALPHA PORT" <linux-alpha@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, Will Deacon <will@kernel.org>, linux-arm-ke
List-Id: linux-arch.vger.kernel.org

On Thu, Oct 10, 2019 at 5:16 PM Kees Cook <keescook@chromium.org> wrote:
>
> Since the EXCEPTION_TABLE is read-only, collapse it into RO_DATA.
>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  arch/xtensa/kernel/vmlinux.lds.S | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Acked-by: Max Filippov <jcmvbkbc@gmail.com>

-- 
Thanks.
-- Max

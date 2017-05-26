From: hpa@zytor.com
Subject: Re: [PATCHv1, RFC 0/8] Boot-time switching between 4- and 5-level paging
Date: Fri, 26 May 2017 12:36:31 -0700
Message-ID: <B4C5A54B-FC84-4B73-8ECC-CD14532CBA2C@zytor.com>
References: <20170525203334.867-1-kirill.shutemov@linux.intel.com> <CA+55aFznnXPDxYy5CN6qVU7QJ3Y9hbSf-s2-w0QkaNJuTspGcQ@mail.gmail.com> <20170526130057.t7zsynihkdtsepkf@node.shutemov.name> <CA+55aFw2HDHRZTYss2xbSTRAZuS1qAFmKrAXsiMp34ngNapTiw@mail.gmail.com> <83F4880B-5D1F-4576-A9B6-7DDF4173E2E5@zytor.com> <40d58ba7-277c-6f4e-a4d7-15425d675dbf@intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <40d58ba7-277c-6f4e-a4d7-15425d675dbf@intel.com>
Sender: owner-linux-mm@kvack.org
To: Dave Hansen <dave.hansen@intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, the arch/x86 maintainers <x86@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Andi Kleen <ak@linux.intel.com>, Andy Lutomirski <luto@amacapital.net>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On May 26, 2017 12:23:18 PM PDT, Dave Hansen <dave=2Ehansen@intel=2Ecom> wr=
ote:
>On 05/26/2017 11:24 AM, hpa@zytor=2Ecom wrote:
>> The only case where that even has any utility is for an application
>> to want more than 128 TiB address space on a machine with no more
>> than 64 TiB of RAM=2E  It is kind of a narrow use case, I think=2E
>
>Doesn't more address space increase the effectiveness of ASLR?  I
>thought KASLR, especially, was limited in its effectiveness because of
>a
>lack of address space=2E

The shortage of address space for KASLR is not addressable by LA57; rather=
, it would have to be addressed by compiling the kernel using a different (=
less efficient) memory model, presumably the "medium" memory model=2E
--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
